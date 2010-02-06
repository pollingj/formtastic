# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe 'SemanticFormBuilder#item_separator' do

  include FormtasticSpecHelper
  
  before do
    @output_buffer = ''
    mock_everything
  end
  
  describe 'when @@item_separator is default (:li)' do 

    it 'should render inputs wrapper in li tags and wrapperd in ol tag' do
      @bob.stub!(:column_for_attribute).and_return(mock('column', :type => :string, :limit => 255))
      semantic_form_for(@new_post) do |builder|
        builder.inputs :for => [:author, @bob] do |bob_builder|
          concat(bob_builder.input(:login))
        end
      end
      
      output_buffer.should have_tag("form > fieldset > ol > li")
    end
  end
  
  describe 'when @@item_separator is set to :div' do
    
    it 'should render inputs wrapper in div tags and have not wrapping ol tag' do
      ::Formtastic::SemanticFormBuilder.item_separator = :div
      
      @bob.stub!(:column_for_attribute).and_return(mock('column', :type => :string, :limit => 255))
      semantic_form_for(@new_post) do |builder|
        builder.inputs :for => [:author, @bob] do |bob_builder|
          concat(bob_builder.input(:login))
        end
      end
      
      output_buffer.should have_tag("form > fieldset > div")
      output_buffer.should_not have_tag("form > fieldset > ol")
    end
  end
  
end
