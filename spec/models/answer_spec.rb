# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '新規登録機能' do
    let(:user_a) { create(:user, name: 'user_a') }
    let(:user_b) { create(:user, name: 'user_b') }
    let(:question) { create(:question, user: user_b) }
    let(:params) do
      {
        text: 'これは、回答本文です',
        user_id: user_a.id,
        question_id: question.id
      }
    end

    context '関連付けたいQuestionのレコードがある場合' do
      context '正しいパラメータが送られてきた場合' do
        it '新規にレコードが追加されている' do
          Answer.create!(params)

          answer = Answer.find_by!(question_id: question.id, user_id: user_a.id)
          expect(answer.text).to eq(params[:text])
        end
      end

      context '誤ったパラメータが送られてきた場合' do
        context 'パラメータが空の場合' do
          it '新規レコード作成に失敗し、ActiveRecord::RecordInvalidの例外を吐く' do
            expect { Answer.create! }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
      end
    end

    context '関連付けたいQuestionのレコードがない場合(削除された場合)' do
      it '新規レコード作成に失敗し、ActiveRecord::RecordInvalidの例外を吐く' do
        Question.find(question.id).delete

        expect { Answer.create!(params) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
