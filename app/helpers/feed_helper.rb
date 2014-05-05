module FeedHelper
	def my_feed(user)
		@friendslist = user.friends #change this to user.friends when friends are implemented
		@postlist = []
		for friend in @friendslist do
			@post = [Micropost.find_by_user_id(friend)]
			@postlist.concat(@post)
		end
		@postlist.sort{ |x,y| y.created_at <=> x.created_at}
		@postlist[0..10]
	end
end
