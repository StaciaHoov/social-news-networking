require 'rails_helper'

describe "Visiting profiles" do
    
    include TestFactories
    
    before do
        @user = authenticated_user #not really authenticated because not signed in
        @post = associated_post(user: @user)
        @comment = Comment.new(user: @user, post: @post, body: "A comment")
        allow(@comment).to receive(:send_favorite_emails) #why here and not in Testfactory?
        @comment.save! #why save!?
    end
    
    describe "not signed in" do
        
        it "shows profile" do
            visit user_path(@user)
            expect(current_path).to eq(user_path(@user))
            
            expect( page ).to have_content(@user.name)
            expect( page ).to have_content(@post.title)
            expect( page ).to have_content(@comment.body)
            
        end
        
    end
end