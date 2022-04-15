using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace BonattermoHelper
{
    class Program
    {
        private static List<string> words;

        static async Task Main(string[] args)
        {
            words = await FiveLengthWords("https://raw.githubusercontent.com/fserb/pt-br/master/conjuga%C3%A7%C3%B5es");
            words.AddRange(await FiveLengthWords("https://raw.githubusercontent.com/fserb/pt-br/master/palavras"));
            words.AddRange(await FiveLengthWords("https://raw.githubusercontent.com/fserb/pt-br/master/verbos"));
            await File.WriteAllLinesAsync("words.txt", words);
            Console.WriteLine("Processo Finalizado!");
        }

        static async Task<List<string>> FiveLengthWords(string url)
        {
            var client = new HttpClient();
            var result = await client.GetAsync(url);
            var content = await result.Content.ReadAsStringAsync();
            return content.Split('\n').Where(x => x.Length == 5).ToList();
        }
    }
}
