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
    DocumentProcessor.new(doc).call

    redirect_to document_path(doc), notice: "Processed: created #{doc.chunks.count} chunks."
  rescue => e
    redirect_to document_path(doc), alert: "Processing failed: #{e.message}"
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end
end
