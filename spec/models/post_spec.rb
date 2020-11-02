require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '投稿が保存できる場合' do
    before do
      @post = FactoryBot.build(:post)
    end
    
    it '必須項目が全てあれば投稿できること' do
      expect(@post).to be_valid
    end
    
    it '画像が無いと保存できない' do
      @post.image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('アイキャッチ画像を入力してください')
    end
    
    it 'タイトルがないと保存できない' do
      @post.title = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('タイトルを入力してください')
    end
    
    it '記事の内容がないと保存できない' do
      @post.content = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('記事の内容を入力してください')
    end

    it "ユーザーが紐付いていないとツイートは保存できない" do
      @post.user = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("ユーザーを入力してください")
    end
    
  end
end