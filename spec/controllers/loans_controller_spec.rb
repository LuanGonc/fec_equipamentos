require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  ######
  describe 'GET #new' do
    it 'atribui um novo Loan à variável @loan e renderiza o template' do
      get :new
      expect(assigns(:loan)).to be_a_new(Loan)
      expect(response).to render_template(:new)
    end
  end

  ######
  describe 'POST #create' do

    context 'com parâmetros válidos para empréstimo' do
      let(:equipment) { create(:equipment, status: 'disponivel') }
      let(:collaborator) { create(:collaborator) }
      let(:valid_params) do
        {
          loan: {
            loan_action: 'emprestimo',
            loan_date: Date.today,
            equipment_id: equipment.id,
            collaborator_id: collaborator.id
          }
        }
      end

      it 'cria um novo empréstimo e redireciona para a página de show' do
        expect do
          post :create, params: valid_params
        end.to change(Loan, :count).by(1)

        expect(response).to redirect_to(Loan.last)
        expect(flash[:notice]).to eq('Notebook emprestado com sucesso.')
      end

      it "altera o status do equipamento para 'emprestado'" do
        post :create, params: valid_params
        expect(equipment.reload.status).to eq('emprestado')
      end
    end

    context 'com parâmetros válidos para devolução' do
      let(:equipment) { create(:equipment, status: 'emprestado') }
      let(:collaborator) { create(:collaborator) }
      let!(:previous_loan) { create(:loan, equipment: equipment, collaborator: collaborator) }

      let(:valid_return_params) do
        {
          loan: {
            loan_action: 'devolucao',
            return_date: Date.today,
            return_reason: 'Retorno por fim de uso',
            equipment_id: equipment.id,
            collaborator_id: collaborator.id
          }
        }
      end

      it 'cria uma devolução e redireciona para a página de show' do
        expect do
          post :create, params: valid_return_params
        end.to change(Loan, :count).by(1)

        expect(response).to redirect_to(Loan.last)
        expect(flash[:notice]).to eq('Notebook devolvido com sucesso.')
      end

      it "altera o status do equipamento para 'disponivel'" do
        post :create, params: valid_return_params
        expect(equipment.reload.status).to eq('disponivel')
      end
    end

    context 'com parâmetros inválidos para empréstimo' do
      let(:equipment) { create(:equipment, status: 'disponivel') }
      let(:collaborator) { create(:collaborator) }

      it "não cria o empréstimo e re-renderiza o template 'new'" do
        expect do
          post :create, params: {
            loan: {
              loan_action: 'emprestimo',
              equipment_id: equipment.id,
              collaborator_id: collaborator.id,
              loan_date: nil
            }
          }
        end.not_to change(Loan, :count)

        expect(response).to render_template(:new)
        expect(assigns(:loan)).to be_invalid
        expect(assigns(:loan).errors[:loan_date]).to include("não pode ficar em branco")
      end
    end

    context 'com parâmetros inválidos para devolução' do
      let(:equipment) { create(:equipment, status: 'emprestado') }
      let(:collaborator) { create(:collaborator) }

      it "não cria a devolução e re-renderiza o template 'new'" do
        expect do
          post :create, params: {
            loan: {
              loan_action: 'devolucao',
              equipment_id: equipment.id,
              collaborator_id: collaborator.id
              # return_date e return_reason ausentes
            }
          }
        end.not_to change(Loan, :count)

        expect(response).to render_template(:new)
        expect(assigns(:loan)).to be_invalid
        expect(assigns(:loan).errors[:return_date]).to include("não pode ficar em branco")
        expect(assigns(:loan).errors[:return_reason]).to include("não pode ficar em branco")
      end
    end

    context 'com parâmetros inválidos para baixa' do
      let(:equipment) { create(:equipment) }
      let(:collaborator) { create(:collaborator) }
      
      it "não cria a baixa e re-renderiza o template 'new'" do
        expect do
          post :create, params: {
            loan: {
              loan_action: 'baixa',
              equipment_id: equipment.id,
              collaborator_id: collaborator.id
              # discard_date e discard_reason ausentes
            }
          }
        end.not_to change(Loan, :count)

        expect(response).to render_template(:new)
        expect(assigns(:loan)).to be_invalid
        expect(assigns(:loan).errors[:discard_date]).to include("não pode ficar em branco")
        expect(assigns(:loan).errors[:discard_reason]).to include("não pode ficar em branco")
      end
    end
  end
end
