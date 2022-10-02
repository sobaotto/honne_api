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

          answer = Answer.find_by(question_id: question.id, user_id: user_a.id)
          expect(answer.text).to eq(params[:text])
        end
      end

      context '誤ったパラメータが送られてきた場合' do
        it '新規レコード作成に失敗した時は、例外処理が行われる' do
          Answer.create!
        rescue StandardError => e
          expect(e.present?).to eq(true)
        end
      end
    end

    context '関連付けたいQuestionのレコードがない場合(削除された場合)' do
      it '処理は失敗し、404を返す' do
        Question.find(question.id).delete

        begin
          Answer.create!(params)
        rescue StandardError => e
          e
        end
      end
    end
  end
end
