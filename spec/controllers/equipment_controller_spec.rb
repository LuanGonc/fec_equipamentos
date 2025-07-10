require 'rails_helper'

RSpec.describe EquipmentController, type: :controller do
  describe 'GET index' do
    let!(:equipment1) { create(:equipment) }
    let!(:equipment2) { create(:equipment) }

    it 'retorna resposta de sucesso (200 OK)' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'atribui @equipment com todos os equipamentos (sem filtros)' do
      get :index
      expect(assigns(:equipments)).to match_array([equipment1, equipment2])
    end

    it 'renderiza a view correta' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    let(:equipment) { create(:equipment) }

    it 'retorna resposta de sucesso (200 OK)' do
      get :show, params: { id: equipment.id }
      expect(response).to have_http_status(:ok)
    end

    it 'atribui @equipment com o equipamento certo' do
      get :show, params: { id: equipment.id }
      expect(assigns(:equipment)).to eq(equipment)
    end

    it 'renderiza a view show' do
      get :show, params: { id: equipment.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST create' do
    context 'com parâmetros válidos' do
      let(:valid_attributes) do
        attributes_for(:equipment)
      end

      it 'cria um novo equipamento' do
        expect do
          post :create, params: { equipment: valid_attributes }
        end.to change(Equipment, :count).by(1)
      end

      it 'redireciona para a página do equipamento' do
        post :create, params: { equipment: valid_attributes }
        expect(response).to redirect_to(Equipment.last)
      end

      it 'define a mensagem de sucesso' do
        post :create, params: { equipment: valid_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_attributes) do
        attributes_for(:equipment, brand: nil) # Marca em branco (obrigatória)
      end

      it 'não cria um novo equipamento' do
        expect do
          post :create, params: { equipment: invalid_attributes }
        end.not_to change(Equipment, :count)
      end

      it 'renderiza novamente a view new' do
        post :create, params: { equipment: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it 'define os erros de validação' do
        post :create, params: { equipment: invalid_attributes }
        expect(assigns(:equipment).errors).not_to be_empty
      end
    end
  end

  describe 'PATCH update' do
    let!(:equipment) { create(:equipment, brand: 'AntigaMarca') }

    context 'com parâmetros válidos' do
      let(:new_attributes) do
        { brand: 'NovaMarca' }
      end

      it 'atualiza o equipamento' do
        patch :update, params: { id: equipment.id, equipment: new_attributes }
        equipment.reload
        expect(equipment.brand).to eq('NovaMarca'.upcase)
      end

      it 'redireciona para a página do equipamento' do
        patch :update, params: { id: equipment.id, equipment: new_attributes }
        expect(response).to redirect_to(equipment)
      end

      it 'define a mensagem de sucesso' do
        patch :update, params: { id: equipment.id, equipment: new_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_attributes) do
        { brand: nil } # Marca em branco = inválido
      end

      it 'não altera o equipamento' do
        patch :update, params: { id: equipment.id, equipment: invalid_attributes }
        equipment.reload
        expect(equipment.brand).to eq('AntigaMarca'.upcase)
      end

      it 'renderiza novamente a view edit' do
        patch :update, params: { id: equipment.id, equipment: invalid_attributes }
        expect(response).to render_template(:edit)
      end

      it 'define os erros de validação' do
        patch :update, params: { id: equipment.id, equipment: invalid_attributes }
        expect(assigns(:equipment).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE destroy' do
    context 'quando o equipamento nunca foi emprestado' do
      let!(:equipment) { create(:equipment) }

      it 'remove o equipamento do banco' do
        expect do
          delete :destroy, params: { id: equipment.id }
        end.to change(Equipment, :count).by(-1)
      end

      it 'redireciona para a listagem com mensagem de sucesso' do
        delete :destroy, params: { id: equipment.id }
        expect(response).to redirect_to(equipment_index_path)
        expect(flash[:notice]).to eq('Equipamento apagado com sucesso.')
      end
    end

    context 'quando o equipamento já foi emprestado' do
      let!(:equipment) { create(:equipment) }
      let!(:collaborator) { create(:collaborator) }

      before do
        create(:loan, equipment: equipment, collaborator: collaborator, loan_action: 'emprestimo',
                      loan_date: Date.today)
      end

      it 'não remove o equipamento' do
        expect do
          delete :destroy, params: { id: equipment.id }
        end.not_to change(Equipment, :count)
      end

      it 'redireciona com uma mensagem de erro' do
        delete :destroy, params: { id: equipment.id }
        expect(response).to redirect_to(equipment_index_path)
        expect(flash[:alert]).to eq('Não é possível apagar um equipamento que já foi emprestado.')
      end
    end
  end
end
