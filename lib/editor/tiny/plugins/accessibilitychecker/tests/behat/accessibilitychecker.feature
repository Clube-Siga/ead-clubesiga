@editor @editor_tiny @tiny_accessibilitychecker
Feature: Tiny editor accessibility checker
  To write accessible content in Tiny, I need to check for accessibility warnings.

  @javascript
  Scenario Outline: Perform basic accessibility validations
    Given I log in as "admin"
    And I open my profile in edit mode
    And I set the field "Description" to "<content>"
    When I click on the "Tools > Accessibility checker" menu item for the "Description" TinyMCE editor
    Then I should see "<result>" in the "Accessibility checker" "dialogue"

    Examples:
      | result                                                                         | content                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | The colours of the foreground and background text do not have enough contrast. | <p style='color: #7c7cff; background-color: #ffffff;'>Hard to read</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | There is a lot of text with no headings.                                       | <p>Sweet roll oat cake jelly-o macaroon donut oat cake. Caramels macaroon cookie sweet roll croissant cheesecake candy jelly-o. Gummies sugar plum sugar plum gingerbread dessert. Tiramisu bonbon jujubes danish marshmallow cookie chocolate cake cupcake tiramisu. Bear claw oat cake chocolate bar croissant. Lollipop cookie topping liquorice croissant. Brownie cookie cupcake lollipop cupcake cupcake. Fruitcake dessert sweet biscuit dragée caramels marzipan brownie. Chupa chups gingerbread apple pie cookie liquorice caramels carrot cake cookie gingerbread. Croissant candy jelly beans. Tiramisu apple pie dessert apple pie macaroon soufflé. Brownie powder carrot cake chocolate. Tart applicake croissant dragée macaroon chocolate donut.</p><p>Jelly beans gingerbread tootsie roll. Sugar plum tiramisu cotton candy toffee pie cotton candy tiramisu. Carrot cake chocolate bar sesame snaps cupcake cake dessert sweet fruitcake wafer. Marshmallow cupcake gingerbread pie sweet candy canes powder gummi bears. Jujubes cake muffin marshmallow candy jelly beans tootsie roll pie. Gummi bears applicake chocolate cake sweet jelly sesame snaps lollipop lollipop carrot cake. Marshmallow cake jelly beans. Jelly beans sesame snaps muffin halvah cookie ice cream candy canes carrot cake. Halvah donut marshmallow tiramisu. Cookie dessert gummi bears. Sugar plum apple pie jelly beans gummi bears tart chupa chups. Liquorice macaroon gummi bears gummies macaroon marshmallow sweet roll cake topping. Lemon drops caramels pie icing danish. Chocolate cake oat cake dessert halvah danish carrot cake apple pie.</p> |
      | Tables should not contain merged cells, as screen readers may not support them.| <table><caption>Dogs that look good in pants</caption><tr><th>Breed</th><th>Coolness</th></tr><tr><td>Poodle</td><td rowspan='2'>NOT COOL</td></tr><tr><td>Doberman</td></tr></table>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
      | Tables should use row and/or column headers.                                   | <table><caption>Dogs that look good in pants</caption><tr><th>Breed</th><td>Coolness</td></tr><tr><td>Poodle</td><td>NOT COOL</td></tr><tr><td>Doberman</td><td>COOL</td></tr></table>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | A table caption is not required, but is generally helpful.                     | <table><tr><th>Breed</th><th>Coolness</th></tr><tr><td>Poodle</td><td>NOT COOL</td></tr><tr><td>Doberman</td><td>COOL</td></tr></table>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |

  @javascript
  Scenario: Perform accessibility validation on images with no alt attribute
    Given I log in as "admin"
    And I open my profile in edit mode
    And I set the field "Description" to "<p>Some plain text</p><img src='http://download.moodle.org/unittest/test.jpg' width='1' height='1'/><p>Some more text</p>"
    And I click on the "Tools > Accessibility checker" menu item for the "Description" TinyMCE editor
    And I should see "Images require alternative text." in the "Accessibility checker" "dialogue"
    And I click on "View" "link" in the "Accessibility checker" "dialogue"
    And I click on the "Image" button for the "Description" TinyMCE editor
    And I wait "1" seconds
    And I click on "This image is decorative only" "checkbox"
    And I set the field "How would you describe this image to someone who can't see it:" to "No more warning!"
    And I press "Save"
    And I click on the "Tools > Accessibility checker" menu item for the "Description" TinyMCE editor
    And I should see "Congratulations, no accessibility issues found!" in the "Accessibility checker" "dialogue"
    And I click on "Close" "button" in the "Accessibility checker" "dialogue"
    And I select the "img" element in position "2" of the "Description" TinyMCE editor
    And I click on the "Image" button for the "Description" TinyMCE editor
    And I set the field "URL" to "http://download.moodle.org/unittest/test.jpg"
    And I click on "Add" "button" in the "Insert image" "dialogue"
    And I wait "1" seconds
    And I set the field "How would you describe this image to someone who can't see it:" to ""
    And I click on "This image is decorative only" "checkbox"
    When I press "Save"
    And I click on the "Tools > Accessibility checker" menu item for the "Description" TinyMCE editor
    Then I should see "Congratulations, no accessibility issues found!" in the "Accessibility checker" "dialogue"

  @javascript
  Scenario: Placeholder element will not be assessed by accessibility checker
    Given I log in as "admin"
    And I open my profile in edit mode
    When I set the field "Description" to "<p>Some plain text</p><img src='/broken-image' width='1' height='1' class='behat-tinymce-placeholder'/><p>Some more text</p>"
    And I click on the "Tools > Accessibility checker" menu item for the "Description" TinyMCE editor
    Then I should see "Congratulations, no accessibility issues found!" in the "Accessibility checker" "dialogue"
