module Api
  module V1
    class MembersController < ApplicationController
      before_action :set_member, only: [:show, :update, :destroy]

      def index
        members = Member.order(created_at: :desc)
        render json: { 
          status: 'SUCCESS', 
          message: 'Loaded members', 
          data: members 
        }
      end

      def show
        render json: { 
          status: 'SUCCESS', 
          message: 'Loaded the member', 
          data: @member 
        }
      end

      def create
        member = Member.new(name: params[:name])
        if member.save
          render json: { 
            status: 'SUCCESS', 
            data: member 
          }
        else
          render json: { 
            status: 'ERROR', 
            data: member.errors 
          }
        end
      end

      def destroy
        @member.destroy
        render json: { 
          status: 'SUCCESS', 
          message: 'Deleted the member', 
          data: @member 
        }
      end

      def update
        if @member.update(name: params[:name])
          render json: { 
            status: 'SUCCESS', 
            message: 'Updated the member', 
            data: @member 
          }
        else
          render json: { 
            status: 'SUCCESS', 
            message: 'Not updated', 
            data: @member.errors 
          }
        end
      end

      private

      def set_member
        @member = Member.find_by(id: params[:id])
      end
    end
  end
end