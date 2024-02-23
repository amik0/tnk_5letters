# https://github.com/dkulagin/kartaslov/tree/master/dataset/kartaslovsent

require 'csv'

module DictionaryService
  class Import
    class_attribute :dataset

    def self.run
      DictionaryService::Import.dataset = CSV.read('db/kartaslovsent.csv', headers: true, col_sep: ';')
                    .map { _1['term'].gsub('ё', 'e') }
                    .delete_if { _1.size != 5 }
                    .uniq
    end
  end
end