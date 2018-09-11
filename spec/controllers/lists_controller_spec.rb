require 'rails_helper'

RSpec.describe ListsController, type: :controller do

  before(:each) do
    @board = Board.create! valid_attributes
  end


  let (:valid_attributes) {
    {name: 'Groceries'}
  }

  let (:invalid_attributes) {
    {name: ''}
  }

  describe "GET #index" do
    it "returns a success response" do
      list = @board.lists.create! valid_attributes
      get :index, params: { board_id: @board.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      list = @board.lists.create! valid_attributes
      get :edit, params: {board_id: @board.id, id: list.id}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { board_id: @board.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      list = @board.lists.create! valid_attributes
      get :edit, params: {board_id: @board.id, id: list.id}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new List" do
        expect {
          post :create, params: {board_id: @board.id, list: valid_attributes}
        }.to change(List, :count).by(1)
      end

      it "redirects to the created list" do 
        post :create, params: {board_id: @board.id, list: valid_attributes}
        expect(response).to redirect_to(board_list_path(@board.id, List.last))
      end
    end

    context "with invalid params" do
      it "does not create a new List" do
        expect {
          post :create, params: {board_id: @board.id, list: invalid_attributes}
        }.to change(List, :count).by(0)
      end

      it "returns a success response" do
        post :create, params: {board_id: @board.id, list: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'Target' }
      }

      it "updates the requested list" do
        list = @board.lists.create! valid_attributes
        put :update, params: {board_id: @board.id, id: list.id, list: new_attributes}
        list.reload
        expect(list.name).to eq(new_attributes[:name])
      end

      it "redirects to the list" do
        list = @board.lists.create! valid_attributes
        put :update, params: {board_id: @board.id, id: list.id, list: valid_attributes}
        expect(response).to redirect_to(board_list_path(@board.id, list.id))
      end
    end

    context "with invalid params" do
      it "does not update the list" do
        list = @board.lists.create! valid_attributes
        put :update, params: {board_id: @board.id, id: list.id, list: invalid_attributes}
        list.reload
        expect(list.name).to_not eq(invalid_attributes[:name])
      end

      it "returns a success response" do
        list = @board.lists.create! valid_attributes
        put :update, params: {board_id: @board.id, id: list.id, list: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested list" do
      list = @board.lists.create! valid_attributes
      expect {
        delete :destroy, params: {board_id: @board.id, id: list.id}
      }.to change(List, :count).by(-1)
    end

    it "redirects to the board's lists" do
      list = @board.lists.create! valid_attributes
      delete :destroy, params: {board_id: @board.id, id: list.id}
      expect(response).to redirect_to(board_path(@board))
    end
  end
end