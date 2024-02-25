class User < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable

  # rolify
  rolify

  # Associations
  has_one_attached :avatar

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :companies, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :team_members
  has_many :teams, through: :team_members

  # Callbacks
  after_initialize :set_default_role, if: :new_record?
  after_create :create_stripe_customer

  # default Role
  def set_default_role
    add_role(:default) if roles.blank?
  end

  # Stripe methods
  def stripe_customer
    Stripe::Customer.list(email: email).data.first
  end

  def subscription_expired?
    subscriptions.none? { |subscription| subscription.status == 'trialing' }
  end

  def days_until_subscription_expiration
    first_subscription = subscriptions.first
    if first_subscription.present? && first_subscription.respond_to?(:current_period_end)
      seconds_until_expiration = first_subscription.current_period_end - Time.now.to_i
      (seconds_until_expiration / 86400).ceil # Convert seconds to days
    end
  end

  private

  def create_stripe_customer
    Stripe::Customer.create(email: email)
  end

  def subscriptions
    @subscriptions ||= Stripe::Subscription.list.data
  end
end
