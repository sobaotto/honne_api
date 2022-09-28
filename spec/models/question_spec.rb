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
    end
    
    context '誤ったパラメータが送られてきた場合' do
      it '新規レコード作成に失敗した時は、例外処理が行われる' do
        begin
          Question.create!()
        rescue => e
          expect(e.present?).to eq(true)
        end
      end
    end
  end
end
