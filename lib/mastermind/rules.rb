# frozen_string_literal: true

module Mastermind
  # Mastermind::Rules sets the rules for a game of Mastermind
  class Rules
    DEFAULTS = {
      code_pegs: %i[red orange yellow green blue purple],
      key_pegs: [:red, :white, nil],
      holes: 4,
      max_guesses: 12,
      duplicates: true,
      blanks: false
    }.freeze

    def initialize(**rules)
      rules = DEFAULTS.merge rules

      self.code_pegs   = rules[:code_pegs]
      self.key_pegs    = rules[:key_pegs]
      self.holes       = rules[:holes]
      self.max_guesses = rules[:max_guesses]
      self.duplicates  = rules[:duplicates]
      self.blanks      = rules[:blanks]
    end

    attr_accessor :code_pegs,
                  :key_pegs,
                  :holes,
                  :max_guesses

    attr_writer :duplicates,
                :blanks

    def duplicates?
      @duplicates
    end

    def blanks?
      @blanks
    end

    def check_code(code)
      %i[
        pass_size_check?
        pass_validity_check?
        pass_duplicates_check?
        pass_blanks_check?
      ].each do |check|
        raise(StandardError, does_not_pass(check)) unless send(check, code.pegs)
      end

      pegs
    end

    private

    def pass_size_check?(pegs)
      pegs.size == holes
    end

    def pass_validity_check?(pegs)
      (pegs - code_pegs).empty?
    end

    def pass_duplicates_check?(pegs)
      duplicates? || pegs.size == pegs.uniq.size
    end

    def pass_blanks_check?(pegs)
      blanks? || pegs.all?
    end

    def does_not_pass(check)
      pass_check = check.to_s.tr('_', ' ').delete '?'
      "Does not #{pass_check}."
    end
  end
end
