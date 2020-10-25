require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    #トップページに遷移する
    visit root_path
    #ログインしていない場合、サインインページに遷移することを確認する
    expect(current_path).to eq new_user_session_path
  end
  
  it 'ログインに成功し、トップページに遷移する' do
    #予めユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    #サインインページに移動する
    visit new_user_session_path
    #ログインしていない場合、サインインページに遷移することを確認する
    expect(current_path).to eq new_user_session_path
    #すでに保存されているユーザのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    #ログインボタンをクリックする
    click_on ('Log in')
    #トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end
  
  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    #予めユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    #トップページに移動する
    visit root_path
    #ログインしていない場合、サインインページに遷移することを確認する
    expect(current_path).to eq new_user_session_path
    #誤ったユーザ情報を入力する
    fill_in 'user_email', with: "111111111@test.com"
    fill_in 'user_password', with: "123456"
    #ログインボタンをクリックする
    click_on ('Log in')
    #サインインページにもどってきていることを確認する
    expect(current_path).to eq new_user_session_path
  
  end

end
