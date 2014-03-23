class Rudini.Routers.ItemsRouter extends Backbone.Router
  
  # Initializes Items router, with a collection of all items.
  # Actual object assigned to RudiniApp.items
  # (and so the "items" collection is available at
  #   "RudiniApp.items.items")
  initialize: (options) ->
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items

  routes:
    ""	        	: "index"
    "/help"	       	: "help"
    "/items/:id"      	: "show"
    "/items"        	: "index"
    "/items/.*"        	: "index"


  renderSidebar: () ->
    @view = new Rudini.Views.Page.SidebarView(items: @items)
    $("#backbone-page").html(@view.render().el)

    # sets height of sidebar to match window size
    # ... there is probably a better (more general) way to do this?
    window_height = $(window).height()
    sidebar_height = window_height - 150
    $("#item-nav-list").height(sidebar_height)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-nav-list"])

  index: ->
    this.renderSidebar()
   
    none_item = '<div class="item" id="item-none">' +
      '<p>Search for an item on the left!</p>' + 
      '<p>Or try the <a href="#koans">koans</a></p>' +
      '</div>'

    $("#item-container").html(none_item)
    

  show: (id) ->
    item = @items.get(id)
    memory = item.memory()

    title = "Item " + item.id + " - " + item.attributes.name 
    document.title = title

    # If sidebar is absent, must be navigating in from another layout
    # thus, render page structure/sidebar
    # if not, just render item show 
    if $("#item-nav-list").length == 0
      this.renderSidebar()
    
    
    @view = new Rudini.Views.Items.ShowView({model: item, memory: memory})
    $("#study-container").hide()
    $("#item-container").show()
    $("#item-container").html(@view.render().el)

    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])


  help: () ->
    document.title = "LSRu - Help"

    item = {id: "0000"}
    item['label'] = "Help"
    item['name'] = "What's up with Rudinium?" 
    item['content'] = """
      <p>
         Rudinium is a packaging of <a href="http://www.amazon.com/Principles-Mathematical-Analysis-Third-Edition/dp/007054235X" target="_blank">Walter Rudin's classic Real Analysis text</a> with the 
         brilliant lectures of <a href="http://www.math.hmc.edu/~su/" target="_blank">Professor Su</a> 
         of <a href="http://www.hmc.edu" target="_blank">Harvey Mudd College</a>. Think of it as
         a video dictionary &mdash; you can quickly search the text of definitions, 
         theorems, proofs, etc. from real analysis, and see them explained with examples
         and commentary which illuminate the often opaque nature of the subject.
      </p>
      <h2>Watch lectures!</h2>
      <p>
         In addition to the searchable definitions and theorems, you can watch entire
         lectures from the spring 2010 Real Analysis course at Harvey Mudd. Just click
         on the "lectures" tab above, and select the topic you want. As you watch, 
         notes will be displayed on the right-hand side to illustrate key concepts and
         definitions.
      </p>
      <h2>Study with SRS!</h2>
      <p>
         If you've <a href="/users/sign_up">created an account</a> with Rudinium 
         (free, simple, and easy &mdash; you can
         delete your account at any time if you are unsatisfied), you can choose to
         study the items you want to remember. We have added over 200 "quizzes" that
         let you test your understanding of a particular real analysis concept. Paired
         with a state-of-the-art spaced repetition learning algorithm, we'll help you
         manage the often difficult task of knowing when to study or review a particular
         concept. While studying, you'll be asked to self-rate your understanding on a
         simple scale of ["Miss!", . . . , "Easy"]. Based on your response, Rudinium will
         have you review that concept again soon (if you didn't understand it very well)
         or in several weeks/months if you already have a firm grasp on that concept. Using spaced
         repetition to study will cut down on time wasted studying
         concepts you already know, and help you to focus on those that are more
         challenging. Simply <a href="/users/sign_up">sign up</a> to get started!
      </p>
      <h2>Use Rudinium like a Pro...</h2>
      <p>
        We've added a few search features for the power-users amongst us. Note, 
        we are still in the process of aligning the Rudinium content with Rudin's
        <a href="http://www.amazon.com/Principles-Mathematical-Analysis-Third-Edition/dp/007054235X" target="_blank">"Principles of Mathematical Analysis"</a>, so bear with us if not every
        equation number from Rudin pulls up an item on Rudinium.
      </p>
      <p>
        <strong>Search Filters</strong> 
      </p>
        <table class="table table-bordered zebra-striped">
          <thead><tr><th>Filter</th><th>Example</th><th>Description</th></tr></thead>
          <tbody>
            <tr><td><strong>rudin:</strong></td><td>rudin:1.36</td><td>Search by Rudin equation number</td></tr>
          <tr><td><strong>chapter:</strong></td><td>chapter:2</td><td>Search by Rudin chapter number</td></tr>
          <tr><td><strong>lecture:</strong></td><td>lecture:5</td><td>Search by lecture number</td></tr>
          <tr><td><strong>section:</strong></td><td>section:euclidean spaces</td><td>Search by Rudin section name</td></tr>
          </tbody>
        </table>
      <p>
        Other ideas? Let us know! Send an email to <a href="mailto:support@learnstream.org">support@learnstream.org</a>. We're happy to answer any questions and provide support as needed.
      </p>
    """

    # If sidebar is absent, must be navigating in from another layout
    # thus, render page structure/sidebar
    # if not, just render item show 
    if $("#item-nav-list").length == 0
      this.renderSidebar()
    

    @view = new Rudini.Views.Items.HelpView({model: item})
    $("#study-container").hide()
    $("#item-container").show()
    $("#item-container").html(@view.render().el)









