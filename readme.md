CarbonCopy
====

CarbonCopy is a Paperclip processor that backs up y our uploads to a specified S3 bucket. Even if you're not using S3 as your Paperclip storage type, you can still use CarbonCopy to back up files there..

###Installation

To install CarbonCopy, create a `paperclip_procesors` folder inside of your Rails application `lib` directory. Then simply place `carbon_copy.rb` inside of it.


###Usage

To use CarbonCopy, you'll need to add it as a processor inside of your model, like so:

    has_attached_file :image, :styles => {
      res2048:  "2048x2048>",
      res960:   "960x960>"
    },
    processors: [:carbon_copy, :thumbnail]


###Configuration

CarbonCopy requires that you provide some confugration varialbes, namely `aws_bucket`, `aws_access_key` and `aws_secret_key`. These variables tell CarbonCopy how to connect to S3 and where to put the uploaded files.

You can pass in these variables at runtime via an options hash in your model or, if you're string all of your uploads in one bucket, inside of `/config/initializers/paperclip.rb` like so:

    Paperclip::Attachment.default_options[:aws_access_key]  = "YOUR AWS PUBLIC ACCESS KEY"
    Paperclip::Attachment.default_options[:aws_secret_key]  = "YOUR AWS SECRET ACCESS KEY"
    Paperclip::Attachment.default_options[:aws_bucket]      = "YOUR AWS BUCKET NAME"
