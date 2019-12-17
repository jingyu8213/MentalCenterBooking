class Location < ApplicationRecord
  # TODO: Check time conflict.
  before_save :calc_end_time
  before_update :calc_end_time
  enum place: [:中关村, :玉泉路, :奥运村, :岳阳路]
  enum weekday: [:Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday, :Sunday]
  belongs_to :teacher
  has_many :schedules

  validates :place, presence: true
  validates :weekday, presence: true
  validates :start_time, presence: true
  validate :valid_start_time

  def calc_end_time
    self.end_time = self.start_time + 1.hour
  end

  def valid_start_time
    unless self.start_time.min == 0 || self.start_time.min == 30
      errors.add(:start_time, "expect xx:00 or xx:30.")
    end
    self.teacher.locations[0..-2].each do |l|
      if self.weekday == l.weekday
        if (self.start_time.change(year:2000, month:1, day:1) - l.start_time).abs < 3600
          errors.add(:start_time, "time conflict")
        end
      end
    end
  end
end
