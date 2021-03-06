# -*- coding: utf-8 -*-
require 'spec_helper'

describe Calil::Book do
  describe 'find' do

    let(:reservable_book) { "4844330845" }
    let(:unreservable_book) { "4798125415" }
    let(:find_book_ids) { [reservable_book, unreservable_book] }
    let(:find_library_ids) { %w(Tokyo_Minato Tokyo_Chiyoda) }

    subject(:books) { @books = Calil::Book.find(find_book_ids, find_library_ids)
      @books
    }
    it 'should reservable_book reservable' do
      books.first.reservable?.should be_true
      books.first.isbn.should eql(reservable_book)
    end

    it 'should unreservable_book unreservable' do
      books.last.reservable?.should be_false
      books.last.isbn.should eql(unreservable_book)
    end

    it 'should reservable_book hava inspect string' do
      books.first.inspect.should eql("#<Book isbn: '4844330845', calilurl: 'http://calil.jp/book/4844330845', reservable?: 'true' systems: [#<System systemid: 'Tokyo_Chiyoda', status: 'Cache', reserveurl: 'http://www.library.chiyoda.tokyo.jp/wo/opc_srh/srh_detail?detail[sid]=151345917', reservable?: 'true'>, #<System systemid: 'Tokyo_Minato', status: 'Cache', reserveurl: '', reservable?: 'false'>]>")
    end

  end
end
