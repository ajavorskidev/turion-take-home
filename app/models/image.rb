require "aws-sdk-s3"

class Image
  attr_reader :mission, :service_client

  def initialize(mission)
    @service_client = Aws::S3::Client.new(
      region:            Rails.application.credentials.aws_region,
      access_key_id:     Rails.application.credentials.access_key_id,
      secret_access_key: Rails.application.credentials.secret_access_key
    )
    @mission = mission
  end

  # Method for fetching a image corresponding to a image key associated with a mission. Returns
  # nothing if the mission is not marked as "Successful". If the mission is completed, and the
  # call to the AWS S3 service is successful, returns a binary file.
  def fetch_image

    response = @service_client.get_object(
      bucket: Rails.application.credentials.bucket,
      key:    @mission.image
    )

    response.body.read
  end
end
