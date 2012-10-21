module Filterable
  extend ActiveSupport::Concern
  
  included do
    scope :pending, where('prospected_at IS NULL')
    scope :prospected, where('prospected_at IS NOT NULL')
    scope :enrolled, where('enrolled_at IS NOT NULL')
    
    scope :by_period, (lambda do |scoped, started_at, ended_at|      
      return if started_at.blank? and ended_at.blank?
      
      started_at = started_at.blank? ? nil : DateTime.parse("#{started_at} 00:00:00 -0300").utc.strftime("%Y-%m-%d %H:%M:%S")
      ended_at = ended_at.blank? ? nil : DateTime.parse("#{ended_at} 23:59:59 -0300").utc.strftime("%Y-%m-%d %H:%M:%S")
      
      predicate = ''
      params = []
      
      if started_at and not ended_at
        params << started_at
        predicate = "%s >= '%s'"
      elsif not started_at and ended_at
        params << ended_at
        predicate = "%s <= '%s'"
      elsif started_at and ended_at
        params << started_at
        params << ended_at
        predicate = "%s BETWEEN '%s' AND '%s'"
      end

      case scoped
      when 'pending'
        constraint = predicate % (['created_at'] + params)
        pending.where(constraint)
      when 'prospected'
        constraint = predicate % (['prospected_at'] + params)
        prospected.where(constraint)        
      when 'enrolled'
        constraint = predicate % (['enrolled_at'] + params)
        enrolled.where(constraint)        
      else
        constraint = predicate % (['created_at'] + params)
        where(constraint)        
      end
    end)
  end
end