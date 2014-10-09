RSpec.shared_examples "with picture" do |record_sym, sizes|

  before(:all) do
    record = create(record_sym)
    PictureUploader.enable_processing = true
    @uploader = PictureUploader.new(record, :picture)
    file = File.expand_path('../../data/gir_piggy.png', __FILE__)
    @uploader.store!(File.open(file))
  end

  after(:all) do
    PictureUploader.enable_processing = false
    @uploader.remove!
  end

  context 'picture sizes' do
    %i(default thumb).each do |type|
      if sizes.key? type
        it "returns the #{described_class} #{type} picture size" do
          expect(described_class.send "#{type}_picture_size").to eq(sizes[type])
        end
      else
        it "doesn't have a #{type} size" do
          expect(described_class.send "#{type}_picture_size").to be_nil
        end
      end
    end
  end

  context 'picture versions' do
    sizes.each do |type, size|
      it "scales the picture to the #{type} size" do
        if type == :default
          expect(@uploader).to be_no_larger_than(*size)
        else
          expect(@uploader.send(type)).to be_no_larger_than(*size)
        end
      end
    end
  end
end
