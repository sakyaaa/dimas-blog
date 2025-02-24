# frozen_string_literal: true

# pundit polity for application
# https://github.com/varvet/pundit
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    !user.nil?
  end

  def new?
    create?
  end

  def update?
    user == record.user || user&.has_role?(:admin)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  # Some kind of view listing records which a particular user has access to
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user&.has_role? :admin
        scope.all
      else
        scope.where(status: 'public').or(scope.where(user: user))
      end
    end

    private

    attr_reader :user, :scope
  end
end
