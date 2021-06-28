require 'searchyll/indexer'
require 'searchyll/configuration'

module Searchyll

  class Generator < Jekyll::Generator

    safe true
    priority :lowest

    # Public: Invoked by Jekyll during the generation phase.
    def generate(site)

      # Gather the configuration options
      configuration = Configuration.new(site)

      # Don't do anything if the Elasticsearch URL is missing
      if configuration.elasticsearch_url.empty?
        Jekyll.logger.info('searchyll: No Elasticsearch URL present, skipping indexing')
        return
      end

      # Prepare the indexer
      indexer = Searchyll::Indexer.new(configuration)
      indexer.start

      # Iterate through the site contents and send to indexer
      # TODO: what are we indexing?
      # site.posts.each do |doc|
      #   indexer << doc.data.merge({
      #     id: doc.id,
      #     content: doc.content
      #   })
      # end

      Jekyll::Hooks.register :posts, :post_render do |post|
        Jekyll.logger.debug(post.output)
      end

      # Signal to the indexer that we're done adding content
      indexer.finish

    # Handle any exceptions gracefully
    rescue => e
      Jekyll.logger.error("Searchyll: #{e.class.name} - #{e.message}")
      backtrace = e.backtrace.join("\n")
      Jekyll.logger.error("Backtrace: #{backtrace}")
      raise(e)
    end

  end

end
