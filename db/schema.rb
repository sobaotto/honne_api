# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_205_054_641) do
  create_table 'answers', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'text', null: false
    t.bigint 'user_id', null: false
    t.bigint 'question_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
  end

  create_table 'chats', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'text', null: false
    t.bigint 'user_id', null: false
    t.bigint 'question_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['question_id'], name: 'index_chats_on_question_id'
    t.index ['user_id'], name: 'index_chats_on_user_id'
  end

  create_table 'questions', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'text', null: false
    t.boolean 'is_public', default: false, null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'question_status', default: 'unresolved', null: false
    t.bigint 'respondent_id', null: false
    t.boolean 'is_anonymous', default: true, null: false
    t.index ['is_anonymous'], name: 'index_questions_on_is_anonymous'
    t.index ['respondent_id'], name: 'index_questions_on_respondent_id'
    t.index ['user_id'], name: 'index_questions_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[name email], name: 'index_users_on_name_and_email', unique: true
  end

  add_foreign_key 'answers', 'questions'
  add_foreign_key 'answers', 'users'
  add_foreign_key 'chats', 'questions'
  add_foreign_key 'chats', 'users'
  add_foreign_key 'questions', 'users'
  add_foreign_key 'questions', 'users', column: 'respondent_id'
end
