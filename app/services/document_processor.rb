# frozen_string_literal: true

class DocumentProcessor
  def initialize(document, chunk_size: 1500, overlap: 200)
    @document = document
    @chunk_size = chunk_size
    @overlap = overlap
  end

  def call
    @document.update!(status: :processing, error_message: nil)

    text = read_text
    chunks = chunk_text(text)

    @document.chunks.delete_all
    chunks.each_with_index do |chunk, idx|
      @document.chunks.create!(position: idx, content: chunk)
    end

    @document.update!(status: :ready)
  rescue => e
    @document.update!(status: :failed, error_message: e.message)
    raise
  end

  private

  def read_text
    raise "No file attached" unless @document.file.attached?

    @document.file.open { |io| io.read }.to_s.strip.tap do |t|
      raise "Empty document" if t.empty?
    end
  end

  def chunk_text(text)
    raise ArgumentError, "overlap must be < chunk_size" if @overlap >= @chunk_size

    chunks = []
    i = 0
    while i < text.length
      slice = text[i, @chunk_size]
      break if slice.nil? || slice.strip.empty?

      chunks << slice
      i += (@chunk_size - @overlap)
    end
    chunks
  end
end
