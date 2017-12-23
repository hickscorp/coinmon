require 'tty-table'

class Tablifier
  class << self
    HEADER ||= [
      'Name',
      'Paid per Unit',
      'Price per Unit',
      'Investment',
      'Value',
      'ROI'
    ].freeze

    def run(data)
      total_investment, total_value, total_earnings = 0, 0, 0
      table = TTY::Table.new(header: HEADER) do |t|
        data.each do |symbol, data|
          investment = data[:investment]
          value = data[:price]
          earnings = data[:earnings]
          total_investment += investment
          total_value += value
          total_earnings += earnings

          t << [
            symbol.upcase,
            data[:paid_per_unit].round(2),
            data[:price_per_unit].round(2),
            investment.round(2),
            value.round(2),
            earnings.round(2)
          ]
        end
        t << [
          'Total',
          'NA',
          'NA',
          total_investment.round(2),
          total_value.round(2),
          total_earnings.round(2)
        ]
      end

      p = Pastel.new
      filter = proc do |val, row, col|
        if [0, table.rows.length].include? row
          p.white.on_bright_black val
        elsif row > 0 && col == 5
          val.to_i > 0 ? p.black.on_green(val) : p.black.on_red(val)
        else
          val
        end
      end

      table.render :ascii, padding: [0, 2, 0, 2], filter: filter
    end
  end
end
