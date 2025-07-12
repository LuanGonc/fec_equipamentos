# spec/controllers/collaborators_controller_spec.rb
require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  describe 'DELETE #destroy' do
    context 'quando o colaborador NÃO possui empréstimos' do
      let!(:collaborator) { create(:collaborator) }

      it 'exclui o colaborador com sucesso' do
        expect do
          delete :destroy, params: { id: collaborator.id }
        end.to change(Collaborator, :count).by(-1)

        expect(response).to redirect_to(collaborators_path)
        expect(flash[:notice]).to eq('Colaborador apagado com sucesso.')
      end
    end
  end

  describe 'POST #create' do
    context 'com parâmetros válidos' do
      let(:valid_attributes) do
        {
          name: 'Fulano da Silva',
          email: 'fulano@example.com',
          department: 'Financeiro'
        }
      end

      it 'cria um novo colaborador' do
        expect do
          post :create, params: { collaborator: valid_attributes }
        end.to change(Collaborator, :count).by(1)

        expect(response).to redirect_to(Collaborator.last)
        expect(flash[:notice]).to eq('Colaborador criado com sucesso.')
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_attributes) do
        {
          name: '', # inválido
          email: 'emailsemarroba', # inválido
          department: ''
        }
      end

      it 'não cria um colaborador e re-renderiza o formulário' do
        expect do
          post :create, params: { collaborator: invalid_attributes }
        end.not_to change(Collaborator, :count)

        expect(response).to render_template(:new)
        expect(assigns(:collaborator).errors).not_to be_empty
      end
    end
  end

  describe 'PATCH #update' do
    let!(:collaborator) { create(:collaborator) }

    context 'com parâmetros válidos' do
      let(:valid_attributes) do
        {
          name: 'Nome Atualizado',
          email: 'atualizado@example.com',
          department: 'RH'
        }
      end

      it 'atualiza o colaborador e redireciona para show' do
        patch :update, params: { id: collaborator.id, collaborator: valid_attributes }

        collaborator.reload
        expect(collaborator.name).to eq('Nome Atualizado'.titleize)
        expect(collaborator.email).to eq('atualizado@example.com'.downcase)
        expect(collaborator.department).to eq('RH'.titleize)

        expect(response).to redirect_to(collaborator_path(collaborator))
        expect(flash[:notice]).to eq('Colaborador atualizado com sucesso.')
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_attributes) do
        {
          name: '', # nome em branco é inválido
          email: 'invalido',
          department: ''
        }
      end

      it 'não atualiza e re-renderiza o formulário de edição' do
        patch :update, params: { id: collaborator.id, collaborator: invalid_attributes }

        expect(response).to render_template(:edit)
        expect(assigns(:collaborator).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:collaborator) { create(:collaborator) }

    it 'exclui o colaborador e redireciona para o index' do
      expect do
        delete :destroy, params: { id: collaborator.id }
      end.to change(Collaborator, :count).by(-1)

      expect(response).to redirect_to(collaborators_path)
      expect(flash[:notice]).to eq('Colaborador apagado com sucesso.')
    end
  end
end
