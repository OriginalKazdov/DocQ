class DocumentsController < ApplicationController
  def index
    @documents = Document.order(created_at: :desc)
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.status = :uploaded

    if @document.save
      redirect_to documents_path, notice: "Document uploaded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def destroy
    document = Document.find(params[:id])
    document.destroy!
    redirect_to documents_path, notice: "Document was deleted."
  end

  def process_chunks
    doc = Document.find(params[:id])
    doc.update!(status: :processing, error_message: nil)

    raise "No file attached" unless doc.file.attached?

    text = doc.file.open { |io| io.read }.to_s.strip
    raise "Empty document" if text.empty?

    chunks = chunk_text(text, chunk_size: 1500, overlap: 200)

    doc.chunks.delete_all
    chunks.each_with_index do |chunk, idx|
      doc.chunks.create!(position: idx, content: chunk)
    end

    doc.update!(status: :ready)
    redirect_to document_path(doc), notice: "Processed: created #{doc.chunks.count} chunks."
  rescue => e
    doc.update!(status: :failed, error_message: e.message) if doc
    redirect_to document_path(doc), alert: "Processing failed: #{e.message}"
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

  def chunk_text(text, chunk_size:, overlap:)
    raise ArgumentError, "overlap must be < chunk_size" if overlap >= chunk_size

    chunks = []
    i = 0
    while i < text.length
      slice = text[i, chunk_size]
      break if slice.nil? || slice.strip.empty?

      chunks << slice
      i += (chunk_size - overlap)
    end
    chunks
  end
end
