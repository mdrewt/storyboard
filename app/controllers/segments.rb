get '/story/:story_id/segment/:segment_id' do
  @story = Story.find(params[:story_id])
  @segment = Segment.find(params[:segment_id])
  erb :segment
end

get '/story/:story_id/segment/:segment_id/new' do
  @parent_id = params[:segment_id]
  @story = Story.find(params[:story_id])
  erb :new_segment
end

post '/story/:story_id/segment/:segment_id/new' do
  segment = Segment.create(body: params[:body], story_id: params[:story_id], parent_id: params[:segment_id])
  redirect "story/#{params[:story_id]}/segment/#{segment.id}"
end

get '/story/:story_id/segment/:segment_id/edit' do
  @story = Story.find(params[:story_id])
  @segment = Segment.find(params[:segment_id])
  if session[:user].id == @segment.user.id
    erb :edit_segment
  else
    erb :permission_denied
  end
end

put '/story/:story_id/segment/:segment_id/edit' do
  segment = Segment.find(params[:segment_id]).update(params(:edit))
  redirect "story/#{params[:story_id]}/segment/#{segment.id}"
end