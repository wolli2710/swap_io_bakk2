require 'integration_test_helper'

class PagesTest < ActionDispatch::IntegrationTest

  should 'show pages' do
    visit "/about"
    assert page.has_content?(I18n.t('pages.about.title'))

    visit "/coverage"
    assert page.has_content?(I18n.t('pages.coverage.title'))

    visit "/contact"
    assert page.has_content?(I18n.t('pages.contact.title'))

    visit "/imprint"
    assert page.has_content?(I18n.t('pages.imprint.title'))

    visit "/terms"
    assert page.has_content?(I18n.t('pages.terms.title'))

    visit "/help"
    assert page.has_content?(I18n.t('pages.help.title'))
  end

  should 'be able to send email via contact_form' do
    visit "/#{I18n.t('routes.contact.as')}"
    fill_in('email_field', :with => "tester@testmail.com")
    fill_in('subject', :with => "Some content on your site...")
    fill_in('body', :with => "I want to inform you about sth...")
    click_on I18n.t('pages.contact.submit')
    assert page.has_content?( I18n.t('pages.contact.msg.success') )
  end

end
