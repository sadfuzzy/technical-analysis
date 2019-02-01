module TechnicalAnalysis
  class Cr < Indicator

    def self.symbol
      "cr"
    end

    # Calculates the cumulative return for the data over the given period
    # https://www.investopedia.com/terms/c/cumulativereturn.asp
    #
    # @param data [Array] Array of hashes with keys (:date_time, :value)
    # @param price_key [Symbol] The hash key for the price data. Default :value
    # @return [Hash] A hash of the results with keys (:date_time, :value)
    def self.calculate(data, price_key: :value)
      Validation.validate_numeric_data(data, price_key)
      Validation.validate_length(data, 1)

      data = data.sort_by_hash_date_time_asc

      output = []
      start_price = data.first[price_key] 

      data.each do |v|
        output << { date_time: v[:date_time], value: ((v[price_key] - start_price) / start_price) }
      end

      output
    end

  end
end