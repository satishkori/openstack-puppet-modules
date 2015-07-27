require 'spec_helper'

describe 'nova::generic_service' do
  describe 'package should come before service' do
    let :pre_condition do
      'include nova'
    end

    let :params do
      {
        :package_name => 'foo',
        :service_name => 'food'
      }
    end

    let :facts do
      { :osfamily => 'Debian' }
    end

    let :title do
      'foo'
    end

    it { is_expected.to contain_service('nova-foo').with(
      'name'    => 'food',
      'ensure'  => 'running',
      'enable'  => true
    )}

    it { is_expected.to contain_service('nova-foo').that_requires(
      ['Package[nova-common]', 'Package[nova-foo]']
    )}
  end
end
