module Yodlee
  class Account
    attr_accessor :id, :name, :institute_id, :institute_name, :account_info, :current_balance, :last_updated

    def initialize(connection)
      @connection = connection
      @account_info, @transactions = nil
    end

    [:simple_transactions, :account_info, :next_update].each do |m|
      define_method m do
        @account_info = @connection.account_info(self) unless @account_info
        m == :account_info ? @account_info : @account_info[m]
      end
    end

    def transactions
      return @transactions if @transactions
      @transactions = @connection.transactions(self)
    end

    def to_s
      "#{@institute_name} - #{@name}"
    end
  end
end
