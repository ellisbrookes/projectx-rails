class User < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable, :lockable, :timeoutable, :validatable

  # create a stripe customer
  after_create do
    Stripe::Customer.create(email: email)
  end

  has_one_attached :avatar

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :companies, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :team_members
  has_many :teams, through: :team_members

  # stripe methods
  def stripe_customer
    Stripe::Customer.list(email: email).data.first
  end

  # def subscription_expired?
  #   Stripe::Subscription.list.data.first.nil? || !Stripe::Subscription.list.data.first.status === 'active'
  # end

  def subscription_expired?
    subscriptions = Stripe::Subscription.list.data
    subscriptions.none? { |subscription| subscription.status == 'active' }
  end

  def subscription_expiring_soon?
    Stripe::Subscription.list.data.first.present? && Stripe::Subscription.list.data.first.trial_end && Stripe::Subscription.list.data.first.trial_end < Time.now.to_i
  end

  def days_until_subscription_expiration
    subscription = Stripe::Subscription.list.data.first

    if subscription.present? && subscription.respond_to?(:current_period_end)
      seconds_until_expiration = subscription.current_period_end - Time.now.to_i
      days_until_expiration = (seconds_until_expiration / 86400).ceil # Convert seconds to days
      return days_until_expiration
    end
  end
end
