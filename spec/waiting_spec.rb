require 'spec_helper'

describe Waiting do
  describe '#wait' do
    let(:max_attempts) { Waiting.default_max_attempts }
    let(:interval) { Waiting.default_interval }

    subject { described_class }

    shared_examples_for 'an in time waiter' do
      before do
        expect(subject).to receive(:sleep).with(interval).exactly(attempts - 1).times
      end

      it 'waits' do
        attempt = 0
        subject.wait do |w|
          attempt += 1
          w.done if attempt >= attempts
        end
      end
    end

    shared_examples_for 'a timed out waiter' do
      before do
        expect(subject).to receive(:sleep).with(interval).exactly(max_attempts).times
      end

      it 'throws' do
        attempt = 0
        expect do
          subject.wait do |w|
            attempt += 1
            w.done if attempt >= attempts
          end
        end.to raise_error(Waiting::TimedOutError, "Timed out after #{max_attempts * interval}s")
      end
    end

    context 'defaults' do
      context 'attempts < max_attempts' do
        let(:attempts) { Waiting.default_max_attempts - 1 }

        it_behaves_like 'an in time waiter'
      end

      context 'attempts == max_attempts' do
        let(:attempts) { Waiting.default_max_attempts }

        it_behaves_like 'an in time waiter'
      end

      context 'attempts > max_attempts' do
        let(:attempts) { Waiting.default_max_attempts + 1 }

        it_behaves_like 'a timed out waiter'
      end
    end

    context 'overriden defaults' do
      let(:max_attempts) { 5 }
      let(:interval) { 1 }

      before do
        Waiting.default_max_attempts = max_attempts
        Waiting.default_interval = interval
      end

      context 'attempts < max_attempts' do
        let(:attempts) { Waiting.default_max_attempts - 1 }

        it_behaves_like 'an in time waiter'
      end

      context 'attempts == max_attempts' do
        let(:attempts) { Waiting.default_max_attempts }

        it_behaves_like 'an in time waiter'
      end

      context 'attempts > max_attempts' do
        let(:attempts) { Waiting.default_max_attempts + 1 }

        it_behaves_like 'a timed out waiter'
      end
    end
  end
end
