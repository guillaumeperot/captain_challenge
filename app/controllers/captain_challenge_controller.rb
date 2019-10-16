class CaptainChallengeController < ApplicationController
    def index
        @characters = Character.order(created_at: :desc).limit(10)
    end
end