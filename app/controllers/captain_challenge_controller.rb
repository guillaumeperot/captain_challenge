class CaptainChallengeController < ApplicationController
    def index
        @characters_ranked = Character.order(rank: :desc, power: :desc).limit(10).group_by(&:rank)
    end
end