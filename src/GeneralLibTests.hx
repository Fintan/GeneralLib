
import utest.Runner;
import tests.TestVector2;
import tests.TestEvents;
import utest.ui.Report;

class GeneralLibTests {
	
	var runner:Runner;
	
	function new() {
		
		runner = new Runner();
		runner.addCase(new TestVector2());
		runner.addCase(new TestEvents());
		
		Report.create(runner);
		runner.run();
		
	}
	
	static function main() {
		new GeneralLibTests();
	}
	
}