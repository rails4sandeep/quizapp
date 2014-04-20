class QuestionsetsController < ApplicationController
  # GET /questionsets
  # GET /questionsets.json
  @@questionsets=Questionset.all
  @@asked_sets=Hash.new
  def index
    @questionsets = Questionset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questionsets }
    end
  end

  # GET /questionsets/1
  # GET /questionsets/1.json
  def show
    @questionset = Questionset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @questionset }
    end
  end

  # GET /questionsets/new
  # GET /questionsets/new.json
  def new
    @questionset = Questionset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @questionset }
    end
  end

  # GET /questionsets/1/edit
  def edit
    @questionset = Questionset.find(params[:id])
  end

  # POST /questionsets
  # POST /questionsets.json
  def create
    @questionset = Questionset.new(params[:questionset])

    respond_to do |format|
      if @questionset.save
        format.html { redirect_to @questionset, notice: 'Questionset was successfully created.' }
        format.json { render json: @questionset, status: :created, location: @questionset }
      else
        format.html { render action: "new" }
        format.json { render json: @questionset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questionsets/1
  # PUT /questionsets/1.json
  def update
    @questionset = Questionset.find(params[:id])

    respond_to do |format|
      if @questionset.update_attributes(params[:questionset])
        format.html { redirect_to @questionset, notice: 'Questionset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @questionset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionsets/1
  # DELETE /questionsets/1.json
  def destroy
    @questionset = Questionset.find(params[:id])
    @questionset.destroy

    respond_to do |format|
      format.html { redirect_to questionsets_url }
      format.json { head :no_content }
    end
  end

  def result
    @score=session[:score]
    @next_set=session[:next_set] if @next_set.nil?
    logger.info "selected: #{params[:selected_answer]}--correct: #{@next_set.correct}"
    respond_to do |format|
      if params[:selected_answer].nil?
        format.html{redirect_to questionsets_ask_url,notice: 'select an answer'}
      end
      if params[:selected_answer].eql? @next_set.correct.to_s
        @score=@score+1
        session[:score]=@score
        flash[:notice]='correct!'
        format.html
      else
        flash[:notice]='In-correct!'
        format.html
      end
    end

  end

  def next
    if session[:question_sets].empty?
      respond_to do |format|
        @score=session[:score]
        @total=Questionset.all.count
        format.html{redirect_to questionsets_finish_url,notice: 'Congratulations! You have finished the quiz' }
      end
    else
      @questionsets=session[:question_sets]
      @next_set=@questionsets.sample
      @questionsets.delete(@next_set)
      session[:question_sets]=@questionsets
      session[:next_set]=@next_set
      @score=session[:score]
      respond_to do |format|
        format.html{render action: 'ask'}
      end
    end
  end


  def start
    session[:score]=0
    @score=session[:score]
    @questionsets=Questionset.all
    @next_set=@questionsets.sample
    @questionsets.delete(@next_set)
    session[:next_set]=@next_set
    session[:question_sets]=@questionsets
    respond_to do |format|
      format.html{render action: 'ask'}
    end
  end

  def ask
    @next_set=session[:next_set] if @next_set.nil?
    @score=session[:score]
    respond_to do |format|
      format.html
    end
  end

  def home
  end

  def finish
    @score=session[:score]
    @total=Questionset.all.count
    # me = FbGraph::User.me(session[:access_token])
    # me.feed!(
    #   :message => 'Updating via FbGraph',
    #   :picture => 'https://graph.facebook.com/matake/picture',
    #   :link => 'https://github.com/nov/fb_graph',
    #   :name => 'FbGraph',
    #   :description => 'A Ruby wrapper for Facebook Graph API'
    # )  
    respond_to do |format|
      format.html
    end
  end

  def share
    logger.info "questions controller access token: #{session[:access_token]}"
    logger.info "graph user: #{me}"
    me = FbGraph::User.me(session[:access_token])
    me.feed!(
      :message => 'Updating via FbGraph',
      :picture => 'https://graph.facebook.com/matake/picture',
      :link => 'https://github.com/nov/fb_graph',
      :name => 'FbGraph',
      :description => 'A Ruby wrapper for Facebook Graph API'
    )
    respond_to do |format|
      format.html{render action: 'finish',notice: 'shared successfully on facebook'}
    end   
  end
end
