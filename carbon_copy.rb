module Paperclip
  class CarbonCopy < Processor
    require 'aws-sdk'

    def initialize(file, options = {}, attachment = nil)
      super
      @file              = file
      @attachment        = attachment
      @aws_access_key    = @attachment.options[:aws_access_key]
      @aws_secret_key    = @attachment.options[:aws_secret_key]
      @aws_bucket        = @attachment.options[:aws_bucket]
      @whiny             = options[:whiny].nil? ? true : options[:whiny]
    end

    def make
      temp_file = File.open(@file.path)
      temp_file.binmode

      begin
        dst = @attachment.path(:original)
        dst[0] = ''

        s3 = AWS::S3.new(:access_key_id => @aws_access_key,:secret_access_key => @aws_secret_key)
        s3.buckets[@aws_bucket].objects[dst].write(:file => @file.path)
      rescue
        raise Paperclip::Error, "Could not upload to S3: Ensure bucket name and credentials are correct." if @whiny
      end

      temp_file
    end
  end
end