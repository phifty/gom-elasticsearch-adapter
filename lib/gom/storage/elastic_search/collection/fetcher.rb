
class GOM::Storage::ElasticSearch::Collection::Fetcher

  def initialize(results)
    @results = results
  end

  def drafts
    drafts = [ ]
    @results.each do |item|
      drafts << GOM::Storage::ElasticSearch::Draft::Builder.new(item).draft
    end
    drafts
  end

end
