require 'calculate_date/weeder'
require 'calculate_date/exceptions'
require 'calculate_date/lexer'
require 'calculate_date/parser'

RSpec.describe CalculateDate::Weeder do
  describe '#weeder' do
    context 'when number is weeded' do
      it 'should still be a number' do
        lexer = CalculateDate::Lexer.new("1 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.expr).to be_a(CalculateDate::AST::Number)
      end

      it 'should still be 1' do
        lexer = CalculateDate::Lexer.new("1 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.expr.value).to eq(1)
      end

      it 'should still be 10' do
        lexer = CalculateDate::Lexer.new("10 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.expr.value).to eq(10)
      end
    end

    context 'when binary operator' do
      it 'should still be a binary_operator' do
        lexer = CalculateDate::Lexer.new("1 day + 1 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast).to be_a(CalculateDate::AST::BinaryOperator)
      end

      it 'should still eq +' do
        lexer = CalculateDate::Lexer.new("1 day + 1 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.token.value).to eq('+')
      end

      it 'should still eq -' do
        lexer = CalculateDate::Lexer.new("1 day - 1 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.token.value).to eq('-')
      end
    end

    context 'when parsing unit' do
      it 'should still be day' do
        lexer = CalculateDate::Lexer.new("1 day")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.unit).to eq('day')
      end

      it 'should rewrite days to day' do
        lexer = CalculateDate::Lexer.new("1 days")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.unit).to eq('day')
      end

      it 'should still be month' do
        lexer = CalculateDate::Lexer.new("1 month")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.unit).to eq('month')
      end

      it 'should rewrite months to month' do
        lexer = CalculateDate::Lexer.new("1 months")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.unit).to eq('month')
      end

      it 'should still be year' do
        lexer = CalculateDate::Lexer.new("1 year")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.unit).to eq('year')
      end

      it 'should rewrite years to year' do
        lexer = CalculateDate::Lexer.new("1 years")
        ast = CalculateDate::Parser.new(lexer).parse

        weeded_ast = CalculateDate::Weeder.new(ast).weed

        expect(weeded_ast.unit).to eq('year')
      end
    end
  end
end