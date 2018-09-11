require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  let(:valid_attributes) {
    {name: 'Board'}
  }

  let(:invalid_attributes) {
    {name: ''}
  }

  describe 'GET #index' do
    it 'Returns HTTP Success' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'Returns HTTP Success' do
      board = Board.create! valid_attributes
      get :show, params: {id: board.id}
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'Returns HTTP Success' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'Returns HTTP Success' do
      board = Board.create! valid_attributes
      get :edit, params: {id: board.id}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'With valid params' do
      it 'Creates a new board' do
        expect {
          post :create, params: {board: valid_attributes}
      }.to change(Board, :count).by(1)
      end

      it 'Redirects to the created board' do
        post :create, params: {board: valid_attributes}
        expect(response).to redirect_to(Board.last)
      end
    end

    context 'Without valid params' do
      it 'Does not create a new board' do
        expect {
          post :create, params: {board: invalid_attributes}
        }.to change(Board, :count).by(0)
      end

      it 'Returns a success response' do
        post :create, params: {board: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'With valid params' do
      let(:new_attributes) {
        {name: 'New Name'}
      }

      it 'Updates the selected board' do
        board = Board.create! valid_attributes
        put :update, params: {id: board.id, board: new_attributes}
        board.reload
        expect(board.name).to eq(new_attributes[:name])
      end

      it 'Redirects to the bank account' do
        board = Board.create! valid_attributes
        put :update, params: {id: board.id, board: new_attributes}
        expect(response).to redirect_to(board)
      end
    end

    context 'Without valid params' do
      it 'Does not update the board' do
        board = Board.create! valid_attributes
        put :update, params: {id: board.id, board: invalid_attributes}
        board.reload
        expect(board.name).to_not eq(invalid_attributes[:name])
      end

      it 'Returns a success response' do
        board = Board.create! valid_attributes
        put :update, params: {id: board.id, board: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'Destroys the selected board' do
      board = Board.create! valid_attributes
      expect {
        delete :destroy, params: {id: board.id}
      }.to change(Board, :count).by(-1)
    end

    it 'Redirects to the boards list' do
      board = Board.create! valid_attributes
      delete :destroy, params: {id: board.id}
      expect(response).to redirect_to(boards_url)
    end
  end
end
