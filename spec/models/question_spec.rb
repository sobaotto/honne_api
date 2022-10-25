# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '新規登録機能' do
    let(:user) { create(:user) }

    context '正しいパラメータが送られてきた場合' do
      it '新規にレコードが追加されている' do
        params = {
          text: 'これは、質問本文です',
          title: 'これはタイトルです',
          user: user
        }
        Question.create!(params)

        question = Question.first
        expect(question.title).to eq(params[:title])
        expect(question.text).to eq(params[:text])
      end

      # 回答がついた時に、question_statusが変更されるテストを書く（仕様が決まり次第）
    end

    context '誤ったパラメータが送られてきた場合' do
      context 'パラメータが空の場合' do
        it '新規レコード作成に失敗し、ActiveRecord::RecordInvalidの例外を吐く' do
          expect { Question.create! }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
