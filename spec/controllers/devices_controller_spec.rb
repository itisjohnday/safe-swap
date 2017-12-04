require 'rails_helper'
require 'faker'

RSpec.describe DevicesController, type: :controller, vcr: true do

  let(:user) { User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Crypto.sha1) }

  before { sign_in(user) }

  render_views

  let(:valid_attributes) do
    {
      title: Faker::HowIMetYourMother.catch_phrase,
      address: Faker::Address.street_address,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      description: Faker::HowIMetYourMother.quote,
      radius: 1,
      termination_date: Faker::Time.forward(1, :morning),
      user_id: user.id
    }
  end

  let(:invalid_attributes) do
    {
      title: '',
      address: Faker::Address.street_address,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      description: Faker::HowIMetYourMother.quote,
      radius: 1,
      termination_date: Faker::Time.forward(1, :morning),
      user_id: user.id
    }
  end

  describe "#index" do
    it "returns all devices" do
      User.create!(first_name: "John", last_name: "Doe", email: "john.doe@email.com", password: "123456")
      Device.create!(title: 'this is a phone', model: "iPhone 7", manufacturer: 'Apple', condition: 'New', price: 75, sold?: false, seller_id: 1, buyer_id: nil )
      Device.create!(title: 'this is a phone', model: "iPhone 7", manufacturer: 'Apple', condition: 'New', price: 75, sold?: false, seller_id: 1, buyer_id: nil )
      get :index
      expect(Device.all).to eq(@devices)
    end
  end

  describe "geocoding" do
    it "geocodes the model on save" do
      location = Location.new(address: "Eiffel Tower", title: "The Eiffel Tower, obv.", description: "comment ca va?")

      expect { location.save }.to change { [location.latitude, location.longitude] }
    end
  end

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, params: {}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'renders the index template' do
      get :index, params: {}
      expect(response).to render_template('index')
    end
    it 'loads all of the events into @events' do
      event1 = Event.create!(valid_attributes)
      event2 = Event.create!(valid_attributes)
      get :index, params: {}

      expect(assigns(:events)).to match_array([event1, event2])
    end
  end

  describe 'GET #show' do

    it 'responds successfully with an HTTP 200 status code' do
      event = Event.create!(valid_attributes)
      get :show, params: { id: event.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      event = Event.create!(valid_attributes)
      get :show, params: { id: event.id }
      expect(response).to render_template('show')
    end

    it 'renders all of an events ads' do
      event = Event.create(valid_attributes)
      ad1 = Ad.create(
        title: Faker::HowIMetYourMother.catch_phrase,
        description: Faker::HowIMetYourMother.quote,
        termination_date: Faker::Time.forward(1, :morning),
        event_id: event.id,
        user_id: user.id
      )
      ad2 = Ad.create(
        title: Faker::HowIMetYourMother.catch_phrase,
        description: Faker::HowIMetYourMother.quote,
        termination_date: Faker::Time.forward(1, :morning),
        event_id: event.id,
        user_id: user.id
      )
      get :show, params: { id: event.id }
      expect(assigns(:ads)).to match_array([ad1, ad2])
    end

    it "shows a Google Maps embedded map on the page" do
      location = Location.create! valid_attributes

      get :show, params: {id: location.to_param}

      expect(response.body).to include("google.com/maps/embed")
      expect(response.body).to include("&q=#{location.title}#{location.address}")
      expect(response.body).to include("AIzaSyDtAswMStHi4-AhxnyggpbrKl3sh5dG0hc")
      expect(response.body).to include(Rails.application.secrets.google_api_key)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new event' do
        expect { post :create, params: { event: valid_attributes } }.to change(Event, :count).by(1)
      end
      it 'redirects to the new event' do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to event_path(id: Event.last.id)
      end
    end
    context 'with invalid attributes' do
      it 'does not save the new event' do
        expect { post :create, params: { event: invalid_attributes } }.to_not change(Event, :count)
      end
      it 're-renders the new method' do
        post :create, params: { event: invalid_attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @event = Event.create valid_attributes
    end
    it 'deletes the event' do
      expect { delete :destroy, params: { id: @event } }.to change(Event, :count).by(-1)
    end
    it 'redirects to ads#index' do
      delete :destroy, params: { id: @event }
      expect(response).to redirect_to events_path
    end
  end

  describe 'PUT #update' do
    before :each do
      @event = Event.create valid_attributes
    end
    context 'valid attributes' do
      let(:new_attributes) { { description: Faker::HowIMetYourMother.quote } }

      it 'updates an existing event' do
        put :update, params: { id: @event.to_param, event: new_attributes }
        @event.reload
        expect(@event.description).to eq(new_attributes[:description])
      end
      it 'redirects to the updated event' do
        put :update, params: { id: @event.to_param, event: new_attributes }
        expect(response).to redirect_to event_path(id: @event)
      end
    end
    context 'invalid attributes' do
      let(:new_attributes) { { description: '' } }
      it 'it does not update the existing event' do
        put :update, params: { id: @event.to_param, event: new_attributes }
        @event.reload
        expect(@event.description).to include(new_attributes[:description])
      end
      it 're-renders the edit method' do
        put :update, params: { id: @event.to_param, event: new_attributes }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'GET #new' do
    it 'responds successfully with an HTTP 200 status code' do
      get :new, params: {}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'renders the new event template' do
      get :new, params: {}
      expect(response).to render_template('events/new')
    end
  end
end