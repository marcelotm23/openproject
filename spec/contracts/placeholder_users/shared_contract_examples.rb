#-- encoding: UTF-8

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2021 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

shared_examples_for 'placeholder user contract' do
  let(:placeholder_user_name) { 'UX Designer' }

  context 'when user with global permission' do
    let(:current_user) { FactoryBot.create(:user, global_permission: %i[add_placeholder_user]) }

    it_behaves_like 'contract is valid'
  end

  it_behaves_like 'contract is valid for active admin users only'

  describe 'validations' do
    let(:current_user) { FactoryBot.build_stubbed :admin }
    context 'name' do
      context 'is valid' do
        it_behaves_like 'contract is valid'
      end

      context 'is not too long' do
        let(:placeholder_user) { PlaceholderUser.new(name: 'X' * 257) }

        it_behaves_like 'contract is invalid'
      end

      context 'is not empty' do
        let(:placeholder_user) { PlaceholderUser.new(name: '') }

        it_behaves_like 'contract is invalid'
      end

      context 'is unique' do
        before do
          PlaceholderUser.create(name: placeholder_user_name)
        end

        it_behaves_like 'contract is invalid'
      end
    end

    describe 'type' do
      context 'type and class mismatch' do
        before do
          placeholder_user.type = User.name
        end

        it_behaves_like 'contract is invalid'
      end
    end
  end
end
