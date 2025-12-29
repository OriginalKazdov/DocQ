class ProcessDocumentJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    doc = Document.find(document_id)
    DocumentProcessor.new(doc).call
  end
end
