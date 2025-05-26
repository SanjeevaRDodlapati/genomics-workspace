#!/bin/tcsh
# Remove redundant GitHub automation scripts

echo "🗑️  REMOVING REDUNDANT SCRIPTS"
echo "=============================="
echo ""

cd /home/sdodl001

# Keep only the best sync scripts (working_sync_check.csh and sync_check.csh)
echo "📊 Removing redundant sync/status scripts..."
cd github_automation/sync_status
set keep_sync = (working_sync_check.csh sync_check.csh)
set remove_sync = (quick_sync_check.csh simple_sync_check.csh simple_status_check.csh simple_status.csh quick_status_check.csh comprehensive_repo_status.csh status_dashboard.csh)

foreach script ($remove_sync)
    if (-f $script) then
        echo "   🗑️  Removing redundant: $script"
        rm $script
    endif
end
echo ""

# Remove redundant auth scripts (keep only the most useful ones)
echo "🔐 Removing redundant auth scripts..."
cd ../auth_setup
set remove_auth = (authentication_fix_complete.csh detailed_ssh_guide_part1.csh detailed_ssh_guide_part2.csh fix_multi_account_auth.csh fix_multi_account_tokens.csh fix_token_authentication.csh fix_remote_urls.csh update_tokens_with_new_scope.csh rebuild_credentials.csh)

foreach script ($remove_auth)
    if (-f $script) then
        echo "   🗑️  Removing redundant: $script"
        rm $script
    endif
end
echo ""

# Remove redundant guide scripts (keep only the essential ones)
echo "📚 Removing redundant guide scripts..."
cd ../guides_docs
set remove_guides = (COMPLETE_USAGE_GUIDE.csh MASTER_SETUP_GUIDE.csh EASY_SETUP_GUIDE.csh FINAL_SETUP_INSTRUCTIONS.csh SUCCESS_SUMMARY.csh FINAL_SUCCESS_SUMMARY.csh next_steps_guide.csh documentation_update_guide.csh)

foreach script ($remove_guides)
    if (-f $script) then
        echo "   🗑️  Removing redundant: $script"
        rm $script
    endif
end
echo ""

# Remove some archive scripts that are truly redundant
echo "📦 Removing most redundant archive scripts..."
cd ../archive
set remove_archive = (best_solutions_ranked.csh complete_github_cli_setup.csh complete_reset_and_setup.csh copy_paste_helper.csh final_multi_account_solution.csh master_setup_status.csh multi_account_admin_solutions.csh system_verification.csh)

foreach script ($remove_archive)
    if (-f $script) then
        echo "   🗑️  Removing redundant: $script"
        rm $script
    endif
end
echo ""

cd /home/sdodl001
echo "✅ CLEANUP COMPLETE!"
echo ""
echo "📊 FINAL SUMMARY:"
echo "   🔧 Core Scripts: $(ls -1 *.csh 2>/dev/null | wc -l)"
echo "   📊 Sync/Status: $(ls -1 github_automation/sync_status/*.csh 2>/dev/null | wc -l)"
echo "   🔐 Auth/Setup: $(ls -1 github_automation/auth_setup/*.csh 2>/dev/null | wc -l)"
echo "   📚 Guides/Docs: $(ls -1 github_automation/guides_docs/*.csh 2>/dev/null | wc -l)"
echo "   📦 Archive: $(ls -1 github_automation/archive/*.csh 2>/dev/null | wc -l)"
echo "   ⚡ Utilities: $(ls -1 github_automation/core_scripts/*.csh 2>/dev/null | wc -l)"
echo ""
echo "🎯 RECOMMENDED USAGE:"
echo "   Daily Push: ./push_all_repos.csh"
echo "   Enhanced Push: ./push_all_repos_enhanced.csh"
echo "   Sync Check: ./github_automation/sync_status/working_sync_check.csh"
echo "   Setup Guide: ./github_automation/guides_docs/DAILY_WORKFLOW_GUIDE.csh"
echo ""
