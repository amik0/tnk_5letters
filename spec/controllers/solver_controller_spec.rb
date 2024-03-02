require 'rails_helper'

RSpec.describe SolverController do
  describe "POST create" do
    describe 'when params are correct' do
      let(:params) do
        {
          attempts: [
            [['м', :white], ['а', :white], ['л', :grey], ['я', :grey], ['р', :grey]],
            [['с', :grey], ['м', :white], ['е', :grey], ['н', :grey], ['а', :white]],
            [['Т', :white], ['о', :grey], ['м', :white], ['а', :white], ['т', :grey]],
            [['ш', :yellow], ['т', :yellow], ['А', :yellow], ['м', :yellow], ['м', :grey]]
          ]
        }
      end

      it 'renders the correct answer' do
        post(:create, params:, as: :json)

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq('result' => ['штамп'])
      end
    end

    describe 'when params are incorrect' do
      let(:params) do
        {
          attempts: [
            [['м', :white], ['а', :white], ['л', :grey], ['я', :grey], ['р', :gray]],
            [['с', :grey], ['м', :white], ['е', :grey], ['н', :grey], ['а', :white]]
          ]
        }
      end

      it 'renders the error' do
        post(:create, params:, as: :json)

        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to eq('error' => 'invalid_attempt')
      end
    end

  end
end