require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:user) { create(:user) }
  let(:gummy) { create(:gummy) }

  describe 'GET /reviews' do
    it 'レビュー一覧ページが正常に表示されること' do
      get reviews_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /reviews/new' do
    context 'ログイン済みの場合' do
      before { login_as(user) }

      it '新規レビュー作成ページが表示されること' do
        get new_review_path
        expect(response).to have_http_status(:success)
      end
    end

    context '未ログインの場合' do
      it 'ログインページにリダイレクトされること' do
        get new_review_path
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST /reviews' do
    context 'ログイン済みの場合' do
      before { login_as(user) }

      context '有効なパラメータの場合' do
        it 'レビューが作成されること' do
          expect {
            post reviews_path, params: {
              review: {
                gummy_name: 'テストグミ',
                flavor: 'ぶどう',
                rating: 5,
                sweetness: 3,
                sourness: 3,
                hardness: 3,
                comment: 'とても美味しい。食感が最高でした！'
              }
            }
          }.to change(Review, :count).by(1)

          expect(response).to have_http_status(:redirect)
          follow_redirect!
          expect(response.body).to include('グミを投稿しました！')
        end
      end

      context '無効なパラメータの場合' do
        it 'レビューが作成されないこと' do
          expect {
            post reviews_path, params: {
              review: {
                gummy_id: nil,
                rating: nil,
                title: '',
                body: ''
              }
            }
          }.not_to change(Review, :count)
        end
      end
    end
  end

  describe 'GET /reviews/:id' do
    let(:review) { create(:review, user: user) }

    it 'レビュー詳細ページが表示されること' do
      get review_path(review)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /reviews/:id' do
    let!(:review) { create(:review, user: user) }

    context 'ログイン済みで自分のレビューの場合' do
      before { login_as(user) }

      it 'レビューが削除されること' do
        expect {
          delete review_path(review)
        }.to change(Review, :count).by(-1)

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
