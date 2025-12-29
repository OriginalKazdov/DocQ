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

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end
end
